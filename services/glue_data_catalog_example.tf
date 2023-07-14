module "glue_data_catalog_example" {
  source                = "../../../../modules/glue_data_catalog"
  base_name             = "example"
  crawler               = {
    Crawler1 = {
      s3_bucket     = module.s3_bucket_example1.name
      s3_prefix     = "/crawler1"
      table_prefix  = "crawler1_"
      schedule      = ""
    },
    Crawler2 = {
      s3_bucket     = module.s3_bucket_example2.name
      s3_prefix     = "/crawler2"
      table_prefix  = "crawler2_"
      schedule      = "cron(0 18 * * ? *)"
    }    
  }
  environment           = var.environment
  region                = var.region
}