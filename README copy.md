# terraform-rvu-interviews

This repo is to be used for interviews. 

Currently, it has the capability of creating infrastrucutre for an analyst interview. The [analyst_interview](https://github.com/uswitch/terraform-rvu-interviews) module will create the required resources to fufil the interview.

* A newly created GCP project
* IAM permissions with conditional access
* A BigQuery Dataset that contains BigQuery views of the interview data.

## Usage

Go to the main.tf file in the root of the repo. Copy the `example` module and paste it at the bottom of the file - there will be a few fields you will need to edit. You can see what the example module looks like below:

```terraform
module "example" {
  source = "./modules/analyst_interview"

  billing_account = var.billing_account
  folder_id       = google_folder.folder.id

  emails        = ["joebloggs@gmail.com"]
  access_expiry = "2021-08-14"
}
```
Let's work our way down the module to understand what exactly needs editing. 
Firstly, the module name needs to be unique - doesn't have to be anything specific but just needs to be unique. 
```terraform
module "something_unique" {
```
Currently, as we only have the one interview module it will remain `analyst_interview` as seen below. 
```terraform
module "something_unique" {
  source = "./modules/analyst_interview"
```
The `billing_account` and the `folder_id` do ***NOT*** need to be edited - they should remain as they are.
```terraform
module "something_unique" {
  source = "./modules/analyst_interview"

  billing_account = var.billing_account
  folder_id       = google_folder.folder.id
```  
You want to add the interviewers and the interviewee that are going to need access to this project. ***One thing you need to be aware of is that for personal Gmail accounts Google will strip any dots `.` from the email*** (more info on this [here](https://support.google.com/mail/answer/7436150?hl=en-GB)). Therefore, if someones email is joe.bloggs@gmail.com please enter it as joebloggs@gmail.com - if you don't this will cause issues with the Terraform state.
```terraform
module "something_unique {
  source = "./modules/analyst_interview"

  billing_account = var.billing_account
  folder_id       = google_folder.folder.id

  emails        = ["joebloggs@gmail.com, luke.scott@rvu.co.uk"]
```
The last field to edit is the `access_expiry` and this will remove the `bigquery.jobUser` role from the emails entered above on the date entered. ***You should enter the date after the interview is due to take place.*** 
```terraform
module "something_unique {
  source = "./modules/analyst_interview"

  billing_account = var.billing_account
  folder_id       = google_folder.folder.id

  emails        = ["joebloggs@gmail.com, luke.scott@rvu.co.uk"]
  access_expiry = "2021-08-14"
}
```
That's it! Now you're ready to raise a PR...

### How do I know what the project is called?
When your PR is merged if you go to the GitHub [Actions](https://github.com/uswitch/terraform-rvu-interviews/actions) tab and check the latest workflow run (this will start with `Merge pull request`). Click `Terraform` and then `Terraform Apply`. You can then search for `id=projects/interview-` and this will display the entire project name - for example, `id=projects/interview-c22a57bab6c19957`

![Project_Name](https://user-images.githubusercontent.com/53513983/135068843-c84b7948-5858-4ff2-a501-49cdf5a44aba.gif)


You can now go to the [GCP Console](https://console.cloud.google.com/) and search for the newly created project.

![Finding_Project](https://user-images.githubusercontent.com/53513983/135069011-d4f269ce-0781-4756-aba1-ec3ba845bcd1.gif)

### Deleting the project

Once you have finished with the interview and no longer require the project, simply raise another PR to remove the module you created and Terraform will automatically destroy all resources it created. 
