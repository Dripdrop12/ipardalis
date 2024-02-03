---
title: {Title}
header_title: {Animal_Id}
description: "iPardalis listings are exclusively juveniles or older - no hatchlings or eggs - we do not sell juveniles under 12 grams of weight regardless of their age. Every iPardalis Panther Chameleon has a life-long guarantee. Whatever issue you encounter, even years later, we want to be part of the solution. Keep in touch, and we will ensure that you have a positive experience."
keywords: ["{sire}", "{dam}", "baby chameleons for sale", "buy panther chameleon", "panther for sale", "panther chameleon price", "ambilobe panther chameleon"]
draft: {tolower(draft)}
banner: {image}
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
soldoutmale: {soldoutmale}
soldoutfemale: {soldoutfemale}
maleprice: {maleprice}
femaleprice: {femaleprice}
name: {`babies-name`}
gender: {`babies-gender`}
baby_image: {`babies-image`}
sire_tree: {sire_tree}
dam_tree: {dam_tree}
price: {base_price}
stringrreplacement:
---

{{{{< load-photoswipe >}}}}

{{{{< gallery >}}}}
  {{{{< figure src="{`babies-image`}.jpg" alt="{`babies-name`} - {str_to_title(sire)} x {str_to_title(dam)} ({hatchend})" >}}}}
  {{{{< figure src="{image}.jpg" alt="{str_to_title(sire)} x {str_to_title(dam)} Lineage Collage" >}}}}
  {{{{< figure src="{dam_tree}" alt="{str_to_title(dam)}'s Pedigree Chart" >}}}}
  {{{{< figure src="{sire_tree}" alt="{str_to_title(sire)}'s Pedigree Chart" >}}}}
  <figcaption><strong>Panther Chameleon ({Animal_Id}) pictured is the exact one available for purchase. {str_to_title(sire)}'s  and {str_to_title(dam)}'s lineage charts pictured last.</strong></figcaption>
{{{{< /gallery >}}}}
