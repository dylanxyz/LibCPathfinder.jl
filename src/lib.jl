module LibPathfinder

using Pathfinder_jll
export Pathfinder_jll

using CEnum

mutable struct CAMetalLayerPrivate end

const CAMetalLayer = CAMetalLayerPrivate

mutable struct PFBuildOptionsPrivate end

mutable struct PFCanvasFontContextPrivate end

mutable struct PFCanvasRenderingContext2DPrivate end

mutable struct PFDestFramebufferGLDevicePrivate end

mutable struct PFDestFramebufferMetalDevicePrivate end

mutable struct PFFillStylePrivate end

mutable struct PFGLDevicePrivate end

mutable struct FKHandlePrivate end

mutable struct PFPath2DPrivate end

mutable struct PFRenderTransformPrivate end

mutable struct PFRendererGLDevicePrivate end

mutable struct PFRendererMetalDevicePrivate end

mutable struct PFResourceLoaderWrapperPrivate end

mutable struct PFSVGScenePrivate end

mutable struct PFScenePrivate end

mutable struct PFSceneProxyPrivate end

mutable struct Stretch end

mutable struct Weight end

const PFCanvasRef = Ptr{PFCanvasRenderingContext2DPrivate}

const PFCanvasFontContextRef = Ptr{PFCanvasFontContextPrivate}

struct PFVector2F
    x::Cfloat
    y::Cfloat
end

const FKHandleRef = Ptr{FKHandlePrivate}

const PFSceneRef = Ptr{PFScenePrivate}

struct PFRectF
    origin::PFVector2F
    lower_right::PFVector2F
end

struct PFTextMetrics
    width::Cfloat
end

const PFLineCap = UInt8

const PFLineJoin = UInt8

struct PFMatrix2x2F
    m00::Cfloat
    m01::Cfloat
    m10::Cfloat
    m11::Cfloat
end

struct PFTransform2F
    matrix::PFMatrix2x2F
    vector::PFVector2F
end

const PFTextAlign = UInt8

const PFTextBaseline = UInt8

const PFFillStyleRef = Ptr{PFFillStylePrivate}

const PFPathRef = Ptr{PFPath2DPrivate}

const PFArcDirection = UInt8

struct PFColorU
    r::UInt8
    g::UInt8
    b::UInt8
    a::UInt8
end

const PFResourceLoaderRef = Ptr{PFResourceLoaderWrapperPrivate}

# typedef const void * ( * PFGLFunctionLoader ) ( const char * name , void * userdata )
const PFGLFunctionLoader = Ptr{Cvoid}

const PFGLDeviceRef = Ptr{PFGLDevicePrivate}

const PFGLVersion = UInt8

const PFGLDestFramebufferRef = Ptr{PFDestFramebufferGLDevicePrivate}

struct PFVector2I
    x::Int32
    y::Int32
end

const PFGLRendererRef = Ptr{PFRendererGLDevicePrivate}

const PFRendererLevel = UInt8

struct PFRendererMode
    level::PFRendererLevel
end

const PFDestFramebufferRef = Ptr{Cvoid}

struct PFColorF
    r::Cfloat
    g::Cfloat
    b::Cfloat
    a::Cfloat
end

const PFRendererOptionsFlags = UInt8

struct PFRendererOptions
    dest::PFDestFramebufferRef
    background_color::PFColorF
    flags::PFRendererOptionsFlags
end

const PFSceneProxyRef = Ptr{PFSceneProxyPrivate}

const PFBuildOptionsRef = Ptr{PFBuildOptionsPrivate}

const PFRenderTransformRef = Ptr{PFRenderTransformPrivate}

struct PFTransform4F
    m00::Cfloat
    m01::Cfloat
    m02::Cfloat
    m03::Cfloat
    m10::Cfloat
    m11::Cfloat
    m12::Cfloat
    m13::Cfloat
    m20::Cfloat
    m21::Cfloat
    m22::Cfloat
    m23::Cfloat
    m30::Cfloat
    m31::Cfloat
    m32::Cfloat
    m33::Cfloat
end

struct PFPerspective
    transform::PFTransform4F
    window_size::PFVector2I
end

const PFSVGSceneRef = Ptr{PFSVGScenePrivate}

function PFCanvasCreate(font_context, size)
    ccall((:PFCanvasCreate, libpathfinder), PFCanvasRef, (PFCanvasFontContextRef, Ptr{PFVector2F}), font_context, size)
end

function PFCanvasDestroy(canvas)
    ccall((:PFCanvasDestroy, libpathfinder), Cvoid, (PFCanvasRef,), canvas)
end

function PFCanvasFontContextCreateWithSystemSource()
    ccall((:PFCanvasFontContextCreateWithSystemSource, libpathfinder), PFCanvasFontContextRef, ())
end

function PFCanvasFontContextCreateWithFonts(fonts, font_count)
    ccall((:PFCanvasFontContextCreateWithFonts, libpathfinder), PFCanvasFontContextRef, (Ptr{FKHandleRef}, Csize_t), fonts, font_count)
end

function PFCanvasFontContextAddRef(font_context)
    ccall((:PFCanvasFontContextAddRef, libpathfinder), PFCanvasFontContextRef, (PFCanvasFontContextRef,), font_context)
end

function PFCanvasFontContextRelease(font_context)
    ccall((:PFCanvasFontContextRelease, libpathfinder), Cvoid, (PFCanvasFontContextRef,), font_context)
end

function PFCanvasCreateScene(canvas)
    ccall((:PFCanvasCreateScene, libpathfinder), PFSceneRef, (PFCanvasRef,), canvas)
end

function PFCanvasFillRect(canvas, rect)
    ccall((:PFCanvasFillRect, libpathfinder), Cvoid, (PFCanvasRef, Ptr{PFRectF}), canvas, rect)
end

function PFCanvasStrokeRect(canvas, rect)
    ccall((:PFCanvasStrokeRect, libpathfinder), Cvoid, (PFCanvasRef, Ptr{PFRectF}), canvas, rect)
end

function PFCanvasFillText(canvas, string, string_len, position)
    ccall((:PFCanvasFillText, libpathfinder), Cvoid, (PFCanvasRef, Ptr{Cchar}, Csize_t, Ptr{PFVector2F}), canvas, string, string_len, position)
end

function PFCanvasStrokeText(canvas, string, string_len, position)
    ccall((:PFCanvasStrokeText, libpathfinder), Cvoid, (PFCanvasRef, Ptr{Cchar}, Csize_t, Ptr{PFVector2F}), canvas, string, string_len, position)
end

function PFCanvasMeasureText(canvas, string, string_len, out_text_metrics)
    ccall((:PFCanvasMeasureText, libpathfinder), Cvoid, (PFCanvasRef, Ptr{Cchar}, Csize_t, Ptr{PFTextMetrics}), canvas, string, string_len, out_text_metrics)
end

function PFCanvasSetLineWidth(canvas, new_line_width)
    ccall((:PFCanvasSetLineWidth, libpathfinder), Cvoid, (PFCanvasRef, Cfloat), canvas, new_line_width)
end

function PFCanvasSetLineCap(canvas, new_line_cap)
    ccall((:PFCanvasSetLineCap, libpathfinder), Cvoid, (PFCanvasRef, PFLineCap), canvas, new_line_cap)
end

function PFCanvasSetLineJoin(canvas, new_line_join)
    ccall((:PFCanvasSetLineJoin, libpathfinder), Cvoid, (PFCanvasRef, PFLineJoin), canvas, new_line_join)
end

function PFCanvasSetMiterLimit(canvas, new_miter_limit)
    ccall((:PFCanvasSetMiterLimit, libpathfinder), Cvoid, (PFCanvasRef, Cfloat), canvas, new_miter_limit)
end

function PFCanvasSetLineDash(canvas, new_line_dashes, new_line_dash_count)
    ccall((:PFCanvasSetLineDash, libpathfinder), Cvoid, (PFCanvasRef, Ptr{Cfloat}, Csize_t), canvas, new_line_dashes, new_line_dash_count)
end

function PFCanvasSetTransform(canvas, transform)
    ccall((:PFCanvasSetTransform, libpathfinder), Cvoid, (PFCanvasRef, Ptr{PFTransform2F}), canvas, transform)
end

function PFCanvasResetTransform(canvas)
    ccall((:PFCanvasResetTransform, libpathfinder), Cvoid, (PFCanvasRef,), canvas)
end

function PFCanvasSave(canvas)
    ccall((:PFCanvasSave, libpathfinder), Cvoid, (PFCanvasRef,), canvas)
end

function PFCanvasRestore(canvas)
    ccall((:PFCanvasRestore, libpathfinder), Cvoid, (PFCanvasRef,), canvas)
end

function PFCanvasSetLineDashOffset(canvas, new_offset)
    ccall((:PFCanvasSetLineDashOffset, libpathfinder), Cvoid, (PFCanvasRef, Cfloat), canvas, new_offset)
end

function PFCanvasSetFontByPostScriptName(canvas, postscript_name, postscript_name_len)
    ccall((:PFCanvasSetFontByPostScriptName, libpathfinder), Cvoid, (PFCanvasRef, Ptr{Cchar}, Csize_t), canvas, postscript_name, postscript_name_len)
end

function PFCanvasSetFontSize(canvas, new_font_size)
    ccall((:PFCanvasSetFontSize, libpathfinder), Cvoid, (PFCanvasRef, Cfloat), canvas, new_font_size)
end

function PFCanvasSetTextAlign(canvas, new_text_align)
    ccall((:PFCanvasSetTextAlign, libpathfinder), Cvoid, (PFCanvasRef, PFTextAlign), canvas, new_text_align)
end

function PFCanvasSetTextBaseline(canvas, new_text_baseline)
    ccall((:PFCanvasSetTextBaseline, libpathfinder), Cvoid, (PFCanvasRef, PFTextBaseline), canvas, new_text_baseline)
end

function PFCanvasSetFillStyle(canvas, fill_style)
    ccall((:PFCanvasSetFillStyle, libpathfinder), Cvoid, (PFCanvasRef, PFFillStyleRef), canvas, fill_style)
end

function PFCanvasSetStrokeStyle(canvas, stroke_style)
    ccall((:PFCanvasSetStrokeStyle, libpathfinder), Cvoid, (PFCanvasRef, PFFillStyleRef), canvas, stroke_style)
end

function PFCanvasFillPath(canvas, path)
    ccall((:PFCanvasFillPath, libpathfinder), Cvoid, (PFCanvasRef, PFPathRef), canvas, path)
end

function PFCanvasStrokePath(canvas, path)
    ccall((:PFCanvasStrokePath, libpathfinder), Cvoid, (PFCanvasRef, PFPathRef), canvas, path)
end

function PFPathCreate()
    ccall((:PFPathCreate, libpathfinder), PFPathRef, ())
end

function PFPathDestroy(path)
    ccall((:PFPathDestroy, libpathfinder), Cvoid, (PFPathRef,), path)
end

function PFPathClone(path)
    ccall((:PFPathClone, libpathfinder), PFPathRef, (PFPathRef,), path)
end

function PFPathMoveTo(path, to)
    ccall((:PFPathMoveTo, libpathfinder), Cvoid, (PFPathRef, Ptr{PFVector2F}), path, to)
end

function PFPathLineTo(path, to)
    ccall((:PFPathLineTo, libpathfinder), Cvoid, (PFPathRef, Ptr{PFVector2F}), path, to)
end

function PFPathQuadraticCurveTo(path, ctrl, to)
    ccall((:PFPathQuadraticCurveTo, libpathfinder), Cvoid, (PFPathRef, Ptr{PFVector2F}, Ptr{PFVector2F}), path, ctrl, to)
end

function PFPathBezierCurveTo(path, ctrl0, ctrl1, to)
    ccall((:PFPathBezierCurveTo, libpathfinder), Cvoid, (PFPathRef, Ptr{PFVector2F}, Ptr{PFVector2F}, Ptr{PFVector2F}), path, ctrl0, ctrl1, to)
end

function PFPathArc(path, center, radius, start_angle, end_angle, direction)
    ccall((:PFPathArc, libpathfinder), Cvoid, (PFPathRef, Ptr{PFVector2F}, Cfloat, Cfloat, Cfloat, PFArcDirection), path, center, radius, start_angle, end_angle, direction)
end

function PFPathArcTo(path, ctrl, to, radius)
    ccall((:PFPathArcTo, libpathfinder), Cvoid, (PFPathRef, Ptr{PFVector2F}, Ptr{PFVector2F}, Cfloat), path, ctrl, to, radius)
end

function PFPathRect(path, rect)
    ccall((:PFPathRect, libpathfinder), Cvoid, (PFPathRef, Ptr{PFRectF}), path, rect)
end

function PFPathEllipse(path, center, axes, rotation, start_angle, end_angle)
    ccall((:PFPathEllipse, libpathfinder), Cvoid, (PFPathRef, Ptr{PFVector2F}, Ptr{PFVector2F}, Cfloat, Cfloat, Cfloat), path, center, axes, rotation, start_angle, end_angle)
end

function PFPathClosePath(path)
    ccall((:PFPathClosePath, libpathfinder), Cvoid, (PFPathRef,), path)
end

function PFFillStyleCreateColor(color)
    ccall((:PFFillStyleCreateColor, libpathfinder), PFFillStyleRef, (Ptr{PFColorU},), color)
end

function PFFillStyleDestroy(fill_style)
    ccall((:PFFillStyleDestroy, libpathfinder), Cvoid, (PFFillStyleRef,), fill_style)
end

function PFEmbeddedResourceLoaderCreate()
    ccall((:PFEmbeddedResourceLoaderCreate, libpathfinder), PFResourceLoaderRef, ())
end

function PFFilesystemResourceLoaderLocate()
    ccall((:PFFilesystemResourceLoaderLocate, libpathfinder), PFResourceLoaderRef, ())
end

function PFFilesystemResourceLoaderFromPath(path)
    ccall((:PFFilesystemResourceLoaderFromPath, libpathfinder), PFResourceLoaderRef, (Ptr{Cchar},), path)
end

function PFResourceLoaderDestroy(loader)
    ccall((:PFResourceLoaderDestroy, libpathfinder), Cvoid, (PFResourceLoaderRef,), loader)
end

function PFGLLoadWith(loader, userdata)
    ccall((:PFGLLoadWith, libpathfinder), Cvoid, (PFGLFunctionLoader, Ptr{Cvoid}), loader, userdata)
end

function PFGLDeviceCreate(version, default_framebuffer)
    ccall((:PFGLDeviceCreate, libpathfinder), PFGLDeviceRef, (PFGLVersion, UInt32), version, default_framebuffer)
end

function PFGLDeviceDestroy(device)
    ccall((:PFGLDeviceDestroy, libpathfinder), Cvoid, (PFGLDeviceRef,), device)
end

function PFGLDestFramebufferCreateFullWindow(window_size)
    ccall((:PFGLDestFramebufferCreateFullWindow, libpathfinder), PFGLDestFramebufferRef, (Ptr{PFVector2I},), window_size)
end

function PFGLDestFramebufferDestroy(dest_framebuffer)
    ccall((:PFGLDestFramebufferDestroy, libpathfinder), Cvoid, (PFGLDestFramebufferRef,), dest_framebuffer)
end

function PFGLRendererCreate(device, resources, mode, options)
    ccall((:PFGLRendererCreate, libpathfinder), PFGLRendererRef, (PFGLDeviceRef, PFResourceLoaderRef, Ptr{PFRendererMode}, Ptr{PFRendererOptions}), device, resources, mode, options)
end

function PFGLRendererDestroy(renderer)
    ccall((:PFGLRendererDestroy, libpathfinder), Cvoid, (PFGLRendererRef,), renderer)
end

function PFGLRendererGetDevice(renderer)
    ccall((:PFGLRendererGetDevice, libpathfinder), PFGLDeviceRef, (PFGLRendererRef,), renderer)
end

function PFSceneProxyBuildAndRenderGL(scene_proxy, renderer, build_options)
    ccall((:PFSceneProxyBuildAndRenderGL, libpathfinder), Cvoid, (PFSceneProxyRef, PFGLRendererRef, PFBuildOptionsRef), scene_proxy, renderer, build_options)
end

function PFRenderTransformCreate2D(transform)
    ccall((:PFRenderTransformCreate2D, libpathfinder), PFRenderTransformRef, (Ptr{PFTransform2F},), transform)
end

function PFRenderTransformCreatePerspective(perspective)
    ccall((:PFRenderTransformCreatePerspective, libpathfinder), PFRenderTransformRef, (Ptr{PFPerspective},), perspective)
end

function PFRenderTransformDestroy(transform)
    ccall((:PFRenderTransformDestroy, libpathfinder), Cvoid, (PFRenderTransformRef,), transform)
end

function PFBuildOptionsCreate()
    ccall((:PFBuildOptionsCreate, libpathfinder), PFBuildOptionsRef, ())
end

function PFBuildOptionsDestroy(options)
    ccall((:PFBuildOptionsDestroy, libpathfinder), Cvoid, (PFBuildOptionsRef,), options)
end

function PFBuildOptionsSetTransform(options, transform)
    ccall((:PFBuildOptionsSetTransform, libpathfinder), Cvoid, (PFBuildOptionsRef, PFRenderTransformRef), options, transform)
end

function PFBuildOptionsSetDilation(options, dilation)
    ccall((:PFBuildOptionsSetDilation, libpathfinder), Cvoid, (PFBuildOptionsRef, Ptr{PFVector2F}), options, dilation)
end

function PFBuildOptionsSetSubpixelAAEnabled(options, subpixel_aa_enabled)
    ccall((:PFBuildOptionsSetSubpixelAAEnabled, libpathfinder), Cvoid, (PFBuildOptionsRef, Bool), options, subpixel_aa_enabled)
end

function PFSceneDestroy(scene)
    ccall((:PFSceneDestroy, libpathfinder), Cvoid, (PFSceneRef,), scene)
end

function PFSceneProxyCreateFromSceneAndRayonExecutor(scene, level)
    ccall((:PFSceneProxyCreateFromSceneAndRayonExecutor, libpathfinder), PFSceneProxyRef, (PFSceneRef, PFRendererLevel), scene, level)
end

function PFSceneProxyDestroy(scene_proxy)
    ccall((:PFSceneProxyDestroy, libpathfinder), Cvoid, (PFSceneProxyRef,), scene_proxy)
end

function PFSVGSceneCreateWithMemory(bytes, byte_len)
    ccall((:PFSVGSceneCreateWithMemory, libpathfinder), PFSVGSceneRef, (Ptr{Cchar}, Csize_t), bytes, byte_len)
end

function PFSVGSceneCreateWithPath(path)
    ccall((:PFSVGSceneCreateWithPath, libpathfinder), PFSVGSceneRef, (Ptr{Cchar},), path)
end

function PFSVGSceneIntoScene(svg)
    ccall((:PFSVGSceneIntoScene, libpathfinder), PFSceneRef, (PFSVGSceneRef,), svg)
end

const PF_LINE_CAP_BUTT = 0

const PF_LINE_CAP_SQUARE = 1

const PF_LINE_CAP_ROUND = 2

const PF_LINE_JOIN_MITER = 0

const PF_LINE_JOIN_BEVEL = 1

const PF_LINE_JOIN_ROUND = 2

const PF_TEXT_ALIGN_LEFT = 0

const PF_TEXT_ALIGN_CENTER = 1

const PF_TEXT_ALIGN_RIGHT = 2

const PF_TEXT_BASELINE_ALPHABETIC = 0

const PF_TEXT_BASELINE_TOP = 1

const PF_TEXT_BASELINE_HANGING = 2

const PF_TEXT_BASELINE_MIDDLE = 3

const PF_TEXT_BASELINE_IDEOGRAPHIC = 4

const PF_TEXT_BASELINE_BOTTOM = 5

const PF_ARC_DIRECTION_CW = 0

const PF_ARC_DIRECTION_CCW = 1

const PF_GL_VERSION_GL3 = 0

const PF_GL_VERSION_GLES3 = 1

const PF_GL_VERSION_GL4 = 2

const PF_RENDERER_OPTIONS_FLAGS_HAS_BACKGROUND_COLOR = 1

const PF_RENDERER_OPTIONS_FLAGS_SHOW_DEBUG_UI = 2

const PF_RENDERER_LEVEL_D3D9 = 1

const PF_RENDERER_LEVEL_D3D11 = 2

# exports
const PREFIXES = ["PF"]
for name in names(@__MODULE__; all=true), prefix in PREFIXES
    if startswith(string(name), prefix)
        @eval export $name
    end
end

end # module
