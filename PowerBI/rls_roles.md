# Power BI RLS Roles

## Roles
- `BranchManagerRole`: filter `DimBranch[Branch_ID]` by logged-in user mapping table.
- `RegionalAnalystRole`: filter by permitted states in `DimLocation`.
- `ExecutiveRole`: unrestricted.

## Mapping Strategy
- Maintain security table `UserBranchAccess` in SQL.
- Import table into model and create relationship to `DimBranch`.
- DAX filter example:
`[UserPrincipalName] = USERPRINCIPALNAME()`
