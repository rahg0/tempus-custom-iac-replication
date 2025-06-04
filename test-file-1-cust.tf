module "foo_bucket" {
  source = "git@github.com:example/repo/gcp/storage/bucket"

  project_context = module.workload_context.project_context
  name            = "foo-owners"
  versioning      = false
  lifecycle_rules = []
}

module "foo_bucket_perms_1" {
  source = "git@github.com:example/repo/iam/storage-bucket-iam"

  storage_bucket = module.foo_bucket.bucket_name
  member         = "serviceAccount:foo-service@random-project.iam.gserviceaccount.com"
  roles = [
    "roles/editor",
  ]
}

module "foo_bucket_perms_2" {
  source = "git@github.com:example/repo/gcp/iam/project-iam"

  project_context = module.workload_context.project_context
  member          = "serviceAccount:foo-service@random-project.iam.gserviceaccount.com"
  roles = [
    "roles/owner",
    "roles/editor",
  ]
}

module "foo_bucket_perms_3" {
  source = "git@github.com:example/repo/iam/storage-bucket-iam"

  storage_bucket = module.foo_bucket.bucket_name
  member         = "group:foo-group@random.com"
  roles = [
    "roles/viewer",
    "roles/owner",
    "roles/editor",
  ]
}

