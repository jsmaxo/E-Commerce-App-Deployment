terraform {
  backend "s3" {
    bucket = "terraform-ecom-s3-023703348895"
    key    = "backend-locking"
    region = "eu-west-1"
    use_lockfile = true
  }
}