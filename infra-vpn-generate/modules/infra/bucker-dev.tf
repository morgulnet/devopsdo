module "bucket-s3" {
  source = "../../../tfmodules/s3"

  bucket_names  = ["s3-devopsdo", "tfstate-devoopsdo"]
  sa_name       = "s3-devopsdo"
  folder_id     = "b1geoe9t09jgup9ol6sp"

  permissions = [
    {
      user       = "s3-devopsdo"
      permission = ["READ", "WRITE"]
    },
    {
      user       = "tfstate-devopsdo"
      permission = ["READ", "WRITE"]
    },
    ]
}
