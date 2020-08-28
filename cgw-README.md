## Cloud Governance Workshop - Setup Steps

### Initial Steps
---

> 1. Change DB Instance from t2.micro to t2.medium
> 2. Uncomment Conformity API script block
> 3. Delete *.decrypt files within modules
> 4. Update Web ELB IP addresses/FQDN in module local.tf files
> 5. Update all participants list on CGW Common Resources locals section (Update 1-day before so participants can get SES emails)
> 6. Update participants list in CGW modules per team basis (Update 1-day before so participants can get SES emails)

### Phase 1 (Manual)
---

> 1. Add Code Server SG to Team Instance

### Phase 2 (with Conformity)
---

> 1. CF Question - Comment to leave clue for Phase 2 with Conformity
> 2. Add Code Server SG to Team Instance

### TODO:
---

> 1. Make security issues in CF template - **ON HOLD**
> 2. Create AWS Challenges - **IN PROGRESS**
> 3. Create Azure Challenges - **IN PROGRESS**
> 4. Fix UI framework issues - **BLOCKER**
> 5. Complete API Server Code - **IN PROGRESS**
> 6. Finalize DB scripts - **IN PROGRESS**
> 7. Auto-remediate - **IN PROGRESS**

### Cleanup
---

> 1. Comment the CGW Common resources terraform template
