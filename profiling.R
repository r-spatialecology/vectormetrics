library(vectormetrics)
devtools::load_all()

vl = get_patches(vector_landscape, "class")
vm_p_exchange_idx(vector_landscape, "class")
Rprof("profile.out")
vm_p_exchange_idx(poz_buildings[1:100,], "building")
Rprof(NULL)
summaryRprof("profile.out")

system.time(vm_p_range_idx(poz_buildings, "building"))
