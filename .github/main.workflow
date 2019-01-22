workflow "Deploy" {
  on = "push"
  resolves = ["WordPress Plugin Deploy"]
}

action "WordPress Plugin Deploy" {
  uses = "./dotorg-plugin-deploy"
}
