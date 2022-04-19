module LibCPathfinder

using Artifacts

include("lib.jl")
include("resources.jl")

using .LibPathfinder

function __init__()
    check_resources()
end

end # module
