using LibCPathfinder
using LibCPathfinder.LibPathfinder
using SimpleDirectMediaLayer.LibSDL2

LoadGLFunction(name, ::Any) = SDL_GL_GetProcAddress(name)
LoadGLFunctionPtr = @cfunction(LoadGLFunction, Ptr{Cvoid}, (Ptr{Cchar}, Ptr{Cvoid}))

SDL_GL_SetAttribute(SDL_GL_CONTEXT_MAJOR_VERSION, 3)
SDL_GL_SetAttribute(SDL_GL_CONTEXT_MINOR_VERSION, 2)
SDL_GL_SetAttribute(SDL_GL_CONTEXT_PROFILE_MASK, SDL_GL_CONTEXT_PROFILE_CORE)
SDL_GL_SetAttribute(SDL_GL_DOUBLEBUFFER, 1)

# Create a window and its OpenGL context
window = SDL_CreateWindow("Game", SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED, 640, 480, SDL_WINDOW_OPENGL)
@assert window != C_NULL "Failed to create SDL window"

gl_context = SDL_GL_CreateContext(window)
@assert gl_context != C_NULL "Failed to create OpenGL context"

# Put the window on screen.
SDL_ShowWindow(window)

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
    PFSceneProxyBuildAndRenderGL(scene_proxy, renderer, PFBuildOptionsCreate())
    SDL_GL_SwapWindow(window)

    event_ref = Ref{SDL_Event}()
    while true
        SDL_WaitEvent(event_ref)
        event = event_ref[].type
        if event == SDL_QUIT
            break
        end
    end
finally
    PFSceneProxyDestroy(scene_proxy)
    PFGLRendererDestroy(renderer)
    SDL_DestroyWindow(window)
    SDL_Quit()
end
