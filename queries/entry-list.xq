xquery version "3.1";

declare namespace output="http://www.w3.org/2010/xslt-xquery-serialization";
declare option output:method "json";
declare option output:indent "yes";

declare variable $name as xs:string external;

let $entries := collection("hunnor")/entry
return array {
  for $entry in $entries
  where starts-with($entry/formGrp[1]/form[1]/orth[1]/text(), $name)
  return map {
    "address": base-uri($entry),
    "id": data($entry/@id),
    "orth": array { $entry/formGrp/form/orth/text()
    }
  }
}
