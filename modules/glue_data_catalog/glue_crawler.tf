resource "aws_glue_crawler" "crawler" {
  for_each      = var.crawler
  database_name = aws_glue_catalog_database.database.name
  name          = "${each.key}${lookup(var.environment-suffix, var.environment)}"
  role          = aws_iam_role.role[0].arn
  schedule      = each.value.schedule
  table_prefix  = each.value.table_prefix

  schema_change_policy {
    delete_behavior = "LOG"
    update_behavior = "LOG"
  }  

  configuration = jsonencode(
    {
      CrawlerOutput = {
        Partitions  = { AddOrUpdateBehavior = "InheritFromTable" }
      }     
      Version = 1 
    }
  )

  s3_target {
    path = "s3://${each.value.s3_bucket}${each.value.s3_prefix}"
  }

  recrawl_policy { 
    recrawl_behavior = "CRAWL_NEW_FOLDERS_ONLY"
  }  
}