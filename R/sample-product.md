---
title: "{`babies-phenotype`} Panther Chameleon from {str_to_title(sire)} x {str_to_title(dam)} ({`babies-name`})"
header_title: "iPardalis | {`babies-phenotype`} Panther Chameleon from {str_to_title(sire)} x {str_to_title(dam)} | {`babies-name`}"
description: {Desc}
keywords: ["{sire}", "{dam}", "{Title}", "baby chameleons for sale", "buy panther chameleon", "panther for sale", "ambilobe panther chameleons for sale", "ambilobe panther chameleon for sale"]
draft: {tolower(draft)}
banner: {image}
canonical_link: {canonical}
sire: {sire}
dam: {dam}
image: {image}
filial: {filial}
desc: {str_trim(desc)}
laid: {laid}
hatchstart: {hatchstart}
hatchend: {hatchend}
shipping: 3 months after hatch
hatchnum: {hatchnum}
clutchsize: {clutchsize}
deposit: {tolower(deposit)}
listed: {tolower(listed)}
reservedmale: {reservedmale}
totalmale: {totalmale}
reservedfemale: {reservedfemale}
totalfemale: {totalfemale}
soldout: {tolower(soldout)}
soldoutmale: {tolower(soldoutmale)}
soldoutfemale: {tolower(soldoutfemale)}
maleprice: {maleprice}
femaleprice: {femaleprice}
name: {`babies-name`}
gender: {`babies-gender`}
maturity: {Maturity}
baby_image: {`babies-image`}
baby_sold: {if (is.na(`babies-sold`) | `babies-sold` == FALSE) tolower(FALSE) else tolower(TRUE)}
baby_reserved: {ifelse(exists("babies-reserved"), ifelse(is.na(`babies-reserved`) | `babies-reserved` == FALSE, tolower(FALSE), tolower(TRUE)), tolower(FALSE))}
phenotype: {`babies-phenotype`}
sire_tree: {sire_tree}
dam_tree: {dam_tree}
price: {base_price}
stringrreplacement:
sitemap: 
  priority: {site_priority}
---

{{{{< load-photoswipe >}}}}

{{{{< gallery >}}}}
  {{{{< figure src="{image}.jpg" caption="{str_to_title(sire)} x {str_to_title(dam)} Lineage Collage | Panther Chameleons for sale" >}}}}
  {{{{< figure src="{dam_tree}" caption="{str_to_title(dam)}'s Pedigree Chart | Panther Chameleons for sale" >}}}}
  {{{{< figure src="{sire_tree}" caption="{str_to_title(sire)}'s Pedigree Chart | Panther Chameleons for sale" >}}}}
  <figcaption itemprop="description"><strong>Ambilobe Panther Chameleon ({`babies-name`}) pictured is the exact chameleon available for purchase. {str_to_title(sire)}'s and {str_to_title(dam)}'s lineage collage and pedigree charts pictured last.</strong></figcaption>
{{{{< /gallery >}}}}
