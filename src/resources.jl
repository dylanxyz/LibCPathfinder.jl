RESOURCES_DIR = ""

function check_resources()
    global RESOURCES_DIR = artifact"resources"
    if isempty(RESOURCES_DIR)
        @error "Could not find resources directory.
        Probably because the resources artifact wasn't downloaded correctly."
    end
end

function load_resources()
    PFFilesystemResourceLoaderFromPath(RESOURCES_DIR)
end