class Target < ISM::Software

    def prepare
        @buildDirectory = true
        super
    end

    def configure
        super

        runMesonCommand(arguments:  "setup                                                  \
                                    --reconfigure                                           \
                                    #{@buildDirectoryNames["MainBuild"]}                    \
                                    --prefix=/usr                                           \
                                    --localstatedir=/var                                    \
                                    -Dsuid_wrapper=true                                     \
                                    -Dglamor=#{option("Libepoxy") ? "true" : "false"}       \
                                    -Dxdmcp=#{option("LibXdmcp") ? "true" : "false"}        \
                                    -Dsecure-rpc=#{option("Libtirpc") ? "true" : "false"}   \
                                    -Dxkb_output_dir=/var/lib/xkb",
                        path:       mainWorkDirectoryPath)
    end

    def build
        super

        runNinjaCommand(path: buildDirectoryPath)
    end

    def prepareInstallation
        super

        runNinjaCommand(arguments:      "install",
                        path:           buildDirectoryPath,
                        environment:    {"DESTDIR" => "#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}"})

        makeDirectory("#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}etc/X11/xorg.conf.d")
        makeDirectory("#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}etc/sysconfig")

        if File.exists?("#{Ism.settings.rootPath}etc/sysconfig/createfiles")
            copyFile(   "/etc/sysconfig/createfiles",
                        "#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}etc/sysconfig/createfiles")
        else
            generateEmptyFile("#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}etc/sysconfig/createfiles")
        end

        createFilesData = <<-CODE
        /tmp/.ICE-unix dir 1777 root root
        /tmp/.X11-unix dir 1777 root root
        CODE
        fileUpdateContent("#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}etc/sysconfig/createfiles",createFilesData)
    end

end
