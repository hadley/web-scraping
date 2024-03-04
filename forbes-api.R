library(tidyverse)
library(httr2)

# Unofficial API ----------------------------------------------------------

req <- request("https://www.forbes.com/forbesapi/org/top-colleges/2023/position/true.json") |>
  req_method("GET") |>
  req_url_query(
    limit = "1000",
    fields = "organizationName,academics,state,financialAid,rank,medianBaseSalary,campusSetting,studentPopulation,squareImage,uri,description,grade",
  ) |>
  req_headers(
    Accept = "*/*",
    Cookie = "_ga_DLD85VJ5QY=GS1.1.1706125631.2.1.1706125873.15.0.0; VWO=27.700; _ketch_consent_v1_=eyJiZWhhdmlvcmFsX2FkdmVydGlzaW5nIjp7InN0YXR1cyI6ImdyYW50ZWQiLCJjYW5vbmljYWxQdXJwb3NlcyI6WyJiZWhhdmlvcmFsX2FkdmVydGlzaW5nIl19LCJhbmFseXRpY3MiOnsic3RhdHVzIjoiZ3JhbnRlZCIsImNhbm9uaWNhbFB1cnBvc2VzIjpbImFuYWx5dGljcyJdfSwiZnVuY3Rpb25hbCI6eyJzdGF0dXMiOiJncmFudGVkIiwiY2Fub25pY2FsUHVycG9zZXMiOlsicHJvZF9lbmhhbmNlbWVudCIsInBlcnNvbmFsaXphdGlvbiJdfSwicmVxdWlyZWQiOnsic3RhdHVzIjoiZ3JhbnRlZCIsImNhbm9uaWNhbFB1cnBvc2VzIjpbImVzc2VudGlhbF9zZXJ2aWNlcyJdfX0%3D; _swb_consent_=eyJlbnZpcm9ubWVudENvZGUiOiJwcm9kdWN0aW9uIiwiaWRlbnRpdGllcyI6eyJfZ29vZ2xlQW5hbHl0aWNzQ2xpZW50SUQiOiJHQTEuMi4zNTcxMjI4NjguMTcwNTI1OTE4OCIsInN3Yl93ZWJzaXRlX3NtYXJ0X3RhZyI6IjU3YzY4NDNhLWQ4ZTktNDBjMy05YmMxLThjYWNkZWU3ZDE2OSJ9LCJqdXJpc2RpY3Rpb25Db2RlIjoidXNfZ2VuZXJhbCIsInByb3BlcnR5Q29kZSI6IndlYnNpdGVfc21hcnRfdGFnIiwicHVycG9zZXMiOnsiYW5hbHl0aWNzIjp7ImFsbG93ZWQiOiJ0cnVlIiwibGVnYWxCYXNpc0NvZGUiOiJkaXNjbG9zdXJlIn0sImJlaGF2aW9yYWxfYWR2ZXJ0aXNpbmciOnsiYWxsb3dlZCI6InRydWUiLCJsZWdhbEJhc2lzQ29kZSI6ImRpc2Nsb3N1cmUifSwiZnVuY3Rpb25hbCI6eyJhbGxvd2VkIjoidHJ1ZSIsImxlZ2FsQmFzaXNDb2RlIjoiZGlzY2xvc3VyZSJ9LCJyZXF1aXJlZCI6eyJhbGxvd2VkIjoidHJ1ZSIsImxlZ2FsQmFzaXNDb2RlIjoiZGlzY2xvc3VyZSJ9fSwiY29sbGVjdGVkQXQiOjE3MDYxMjU4Njh9; _ga=GA1.2.357122868.1705259188; _gid=GA1.2.115243211.1706121218; us_privacy=1---; usprivacy=1---; BCSessionID=2ae07b14-70be-40b1-9e90-ed5d91b1be4f; ki_r=; ki_t=1706121218201%3B1706121218201%3B1706125866455%3B1%3B4; _fbp=fb.1.1706121217898.164324328; _gcl_au=1.1.1366914331.1705344922; client_id=14d486f22e5f65b3107348cd0ffeaa50923; AWSALB=oO6tjMJsKH/vFhXIy3y8laTfDHeqrrSuY87/f5HBXNTLwnRhNP6rNTsYSOUaJj/VMTRQI8KIoLWn09u1QU0lWNS6qWtquc3dcgBzfY61NtKREes5PT5X8qEl2+VS; AWSALBCORS=oO6tjMJsKH/vFhXIy3y8laTfDHeqrrSuY87/f5HBXNTLwnRhNP6rNTsYSOUaJj/VMTRQI8KIoLWn09u1QU0lWNS6qWtquc3dcgBzfY61NtKREes5PT5X8qEl2+VS; _gat_UA-5883199-3=1; AMP_TOKEN=%24NOT_FOUND; _dc_gtm_UA-5883199-3=1; _swb=57c6843a-d8e9-40c3-9bc1-8cacdee7d169; rbzid=CXwv4IPKOa5WMsN9vGfFx/FfHDJXwSL2pHJ/swUFnuvHRpgd1qGWgsSHDvkfxbe6A3W7IDkaJbmIeiPvd/wC7NLDIMS6nZ4N6B7HWA1lvWFqWciQ/+GZ1Bm7YCvrGGhXO59tvv6mZYAXbx6MHiL6+/BVKFl8m2Z5gx0M2r0M2j9D/QiW7bH4TR8S/oJmWPQi7TJT5F+3SMGf6SjtfG64f74hLDwf+zEy5y95JETCHlw7Og8eg5QO5AALhKK+rhPV4z7F29XqrM2aGXgKHz//+Q==; rbzsessionid=da3b925ab2cf238acdfa18f6e699045b; _ga_HY3LZWHH6W=GS1.1.1705344921.1.1.1705345703.0.0.0; _uetvid=a2f10940b3d711ee8c1881f6a3138e42; amp_9c5697=N1292876525...1hk77ksom.1hk77kvfo.2.2.4; notice_behavior=implied,us; fadve2etidvcnt=2; _clck=10sfr1j%7C2%7Cfif%7C0%7C1474; fadve2etid=N1292876525; fadvfpuid=FA77ce891e24882d9a03e9d2bc5bf16cf3; _ga_0Y2Y7WWQP1=GS1.1.1705259187.1.1.1705259215.0.0.0; _ga_JFZ3B3QM86=GS1.1.1705259187.1.1.1705259215.0.0.0; cmapi_cookie_privacy=permit 1,2,3; fadvuke2etid=N255829421; blaize_session=d72df655-7d08-4673-bbd3-beadbe316b40; blaize_tracking_id=418dd2e2-817f-48c7-9792-e36d6ce05bf9",
    `Accept-Language` = "en-GB,en-US;q=0.9,en;q=0.8",
    Host = "www.forbes.com",
    `User-Agent` = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.2.1 Safari/605.1.15",
    `Accept-Encoding` = "gzip, deflate, br",
  ) |>
  req_perform()

req <- request("https://www.forbes.com/forbesapi/org/top-colleges/2023/position/true.json") |>
  req_url_query(limit = "1000") |>
  req_perform()

colleges <- tibble(json = resp_body_json(req))
colleges |>
  unnest_wider(json) |>
  select(organizationsLists) |>
  unnest_longer(organizationsLists) |>
  unnest_wider(organizationsLists)
