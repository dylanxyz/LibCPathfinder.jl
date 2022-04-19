using Clang.Generators
using Pathfinder_jll

cd(@__DIR__)

include_dir = joinpath(Pathfinder_jll.artifact_dir, "include") |> normpath
pathfinder_h = joinpath(include_dir, "pathfinder.h") |> normpath
@assert isfile(pathfinder_h)

options = load_options(joinpath(@__DIR__, "generator.toml"))

args = get_default_args()
push!(args, "-I$include_dir")

ctx = create_context([pathfinder_h], args, options)

build!(ctx)