-- ImGui项目
project "ImGui"
    kind "StaticLib"        -- 项目类型：静态链接库
    language "C++"          -- 使用C++语言进行编译
    staticruntime "on"      -- 静态链接：启用静态运行时库
    warnings "off"          -- 关闭警告信息

    -- 目标文件输出目录：binary/[输出目录]/[项目名]
    targetdir ("binary/" .. outputdir .. "/%{prj.name}")
    -- 中间文件输出目录：intermediate/[输出目录]/[项目名]
    objdir ("intermediate/" .. outputdir .. "/%{prj.name}")

    -- 所有平台通用的源文件和头文件
    files
    {
        -- ImGui 核心文件
       "imconfig.h",
		"imgui.h",
		"imgui.cpp",
		"imgui_draw.cpp",
		"imgui_internal.h",
		"imgui_widgets.cpp",
		"imstb_rectpack.h",
		"imstb_textedit.h",
		"imstb_truetype.h",
		"imgui_demo.cpp"
    }

    -- 包含目录：需要能找到后端头文件
    includedirs
    {
        ".",       -- 当前ImGui根目录
        "examples",-- 案例文件目录
        "backends" -- 后端文件目录
    }

    -- Linux系统特定配置
    filter "system:linux"
        pic "On"                       -- 启用位置无关代码（Position Independent Code）
        systemversion "latest"         -- 使用最新的系统版本
        
        -- Linux平台特有源文件
        files
        {

        }

        -- Linux平台宏定义
        defines
        {

        }

        -- Linux下需要显式链接OpenGL库
        links { "GL" }

    -- macOS系统特定配置
    filter "system:macosx"
        pic "On"                       -- 启用位置无关代码

        -- macOS平台特有源文件（.m为Objective-C文件）
        files
        {

        }

        -- macOS平台宏定义
        defines
        {

        }

        -- macOS下需要链接特定的框架
        links 
        {
            "OpenGL.framework",
            "Cocoa.framework",
            "IOKit.framework" 
        }

    -- Windows系统特定配置
    filter "system:windows"
        systemversion "latest"         -- 使用最新的系统版本

        -- Windows平台特有源文件
        files
        {

        }

        -- Windows平台宏定义
        defines 
        { 
            "_CRT_SECURE_NO_WARNINGS"
        }

    -- Debug配置
    filter "configurations:Debug"
        runtime "Debug"       -- 使用调试运行时
        symbols "on"          -- 生成调试符号

    -- Release配置
    filter "configurations:Release"
        runtime "Release"     -- 使用发布运行时
        optimize "speed"      -- 优化执行速度

    -- Dist（分发）配置
    filter "configurations:Dist"
        runtime "Release"     -- 使用发布运行时
        optimize "speed"      -- 优化执行速度
        symbols "off"         -- 不生成调试符号（减小体积）