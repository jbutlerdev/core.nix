return {
  "mfussenegger/nvim-dap",
  config = function()
    local dap = require("dap")

    dap.adapters.ruby = function(callback, config)
      local script
      local args

      if config.test then
        args = {
          "exec",
          "rdbg",
          "--open",
          "--port",
          "${port}",
          "-c",
          "--",
          "ruby",
          "-Itest",
          script,
        }
      else
        args = { "exec", "rdbg", "--open", "--nonstop", "--port", "${port}", "-c", "--", "ruby", script }
      end

      callback({
        type = "server",
        host = "127.0.0.1",
        port = "${port}",
        executable = {
          command = "bundle",
          args = args,
        },
      })
    end

    dap.configurations.ruby = {
      {
        type = "ruby",
        name = "debug run test file",
        request = "attach",
        localfs = true,
        script = "${file}",
        test = true,
      },
      {
        type = "ruby",
        name = "debug file",
        request = "attach",
        localfs = true,
        script = "${file}",
      },
    }
  end,
}
