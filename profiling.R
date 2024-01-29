library(vectormetrics)
devtools::load_all()

vl = get_patches(vector_landscape, "class")
Rprof("profile.out")
vm_p_fullness(vl, "class")
Rprof(NULL)
summaryRprof("profile.out")

system.time(vm_p_range(poz_buildings, "building"))
