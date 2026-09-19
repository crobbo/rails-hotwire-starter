# Keep Rails asset preparation on the same package manager and lockfile as Docker.
# cssbundling-rails otherwise prefers Bun when it is installed alongside Yarn.
task "assets:install_dependencies" do
  sh "yarn", "install", "--frozen-lockfile"
end

{ "javascript:build" => "build", "css:build" => "build:css" }.each do |task_name, script|
  build_task = Rake::Task[task_name].clear_actions.clear_prerequisites
  build_task.enhance([ "assets:install_dependencies" ]) unless ENV["SKIP_YARN_INSTALL"] || ENV["SKIP_BUN_INSTALL"]
  build_task.enhance { sh "yarn", script }
end
