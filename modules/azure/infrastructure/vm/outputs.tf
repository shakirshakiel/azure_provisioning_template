output "content" {
  value       = local_file.file.content
  sensitive   = false
  description = "description"
  depends_on  = []
}

output "file_name" {
  value       = local_file.file.filename
  sensitive   = false
  description = "description"
  depends_on  = []
}
