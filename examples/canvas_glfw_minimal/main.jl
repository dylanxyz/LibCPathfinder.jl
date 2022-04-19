using GLFW
using LibCPathfinder
using LibCPathfinder.LibPathfinder

LoadGLFunction(name, ::Any) = GLFW.GetProcAddress(unsafe_string(name))
LoadGLFunctionPtr = @cfunction(LoadGLFunction, Ptr{Cvoid}, (Ptr{Cchar}, Ptr{Cvoid}))

GLFW.WindowHint(GLFW.CONTEXT_VERSION_MAJOR, 3)
GLFW.WindowHint(GLFW.CONTEXT_VERSION_MINOR, 2)
GLFW.WindowHint(GLFW.OPENGL_FORWARD_COMPAT, true)
GLFW.WindowHint(GLFW.OPENGL_PROFILE, GLFW.OPENGL_CORE_PROFILE)

# Create a window and its OpenGL context
window = GLFW.CreateWindow(640, 480, "GLFW.jl")
@assert window != C_NULL "Could not create GLFW window"

# Make the window's context current
GLFW.MakeContextCurrent(window)

try
    PFGLLoadWith(LoadGLFunctionPtr, C_NULL)

    framebuffer = PFGLDestFramebufferCreateFullWindow(PFVector2I(640, 480) |> Ref)
    device = PFGLDeviceCreate(PF_GL_VERSION_GL3, 0)
    resources = LibCPathfinder.load_resources()
    background = PFColorF(1.0, 1.0, 1.0, 1.0)
    options = PFRendererOptions(framebuffer, background, PF_RENDERER_OPTIONS_FLAGS_HAS_BACKGROUND_COLOR) |> Ref
    mode = PFRendererMode(PF_RENDERER_LEVEL_D3D9) |> Ref
    global renderer = PFGLRendererCreate(device, resources, mode, options)
    canvas = PFCanvasCreate(PFCanvasFontContextCreateWithSystemSource(), PFVector2F(640, 480) |> Ref)

    # Set line width.
    PFCanvasSetLineWidth(canvas, 10.0f00)

    # Draw walls.
    PFCanvasStrokeRect(canvas, PFRectF(PFVector2F(75.0f0, 140.0f0), PFVector2F(225.0f0, 250.0f0)) |> Ref)

    # Draw door.
    PFCanvasFillRect(canvas, PFRectF(PFVector2F(130.0f0, 190.0f0), PFVector2F(170.0f0, 250.0f0)) |> Ref)

    # Draw roof.
    path = PFPathCreate()
    PFPathMoveTo(path, PFVector2F(50.0, 140.0)  |> Ref)
    PFPathLineTo(path, PFVector2F(150.0, 60.0)  |> Ref)
    PFPathLineTo(path, PFVector2F(250.0, 140.0) |> Ref)
    PFPathClosePath(path)
    PFCanvasStrokePath(canvas, path)

    # Render the canvas to screen.
    scene = PFCanvasCreateScene(canvas)
    global scene_proxy = PFSceneProxyCreateFromSceneAndRayonExecutor(scene, PF_RENDERER_LEVEL_D3D9)

    # Loop until the user closes the window
    while !GLFW.WindowShouldClose(window)
        # Render here
        PFSceneProxyBuildAndRenderGL(scene_proxy, renderer, PFBuildOptionsCreate())

        # Swap front and back buffers
        GLFW.SwapBuffers(window)

        # Poll for and process events
        GLFW.PollEvents()
    end
finally
    PFGLRendererDestroy(renderer)
    PFSceneProxyDestroy(scene_proxy)
    GLFW.DestroyWindow(window)
end