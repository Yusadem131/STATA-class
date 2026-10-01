version 19.5

import excel "nlsw88.xlsx", sheet("nolabels") firstrow clear
generate ln_wage = ln(wage), after(wage)
label variable ln_wage "Log hourly wage ($)"
label variable tenure "Job tenure (years)"
label variable union "Union membership"
label define yesno 0 "No" 1 "Yes"
label values union yesno
label variable collgrad "Graduated from college"
label values collgrad yesno
encode racecat, generate(race)
save nlsw88

describe
codebook age-collgrad
summarize *wage
table (union) (collgrad) ()
table (union) (collgrad) (), statistic(mean wage)
db dtable
dtable hours tenure i.union i.race
dtable hours tenure i.union i.race, by(collgrad)
histogram ln_wage
histogram ln_wage, normal
twoway (scatter ln_wage tenure)
twoway (scatter ln_wage tenure) (lfit ln_wage tenure)
twoway (scatter ln_wage tenure) (lfit ln_wage tenure, lwidth(thick))
twoway (scatter ln_wage tenure) (lfit ln_wage tenure, lwidth(thick)), by(collgrad)
regress ln_wage hours i.collgrad union##c.tenure
regress
regress, base
margins union, at(tenure=(0(5)25)) plot
