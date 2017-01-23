
<#
    .Notes
    Created: 23/01/2017 
    Author: Luke Griffith

    .Synopsis
    Creates a property attribute that can be mapped to class properties.

    .Description
    apiObject informs the Mapper that this property is a member 
    of the API and should be mapped accordingly.

    .Example
        class Software {
            [apiObject(shouldQuery=$true)]
            [String]$Name
            ...
    
#>
class apiObject : System.Attribute {
    [bool]$shouldQuery
}


<#
    .Synopsis
    Maps objects from an external api.

    .Description
    Queries external api and returns objects with a concrete type. 

    .Example   
        [apiMapper]::Query([Software]$software, @{SoftwareName=$name})

#>
class apiMapper {




}

class Software {

    [apiObject(shouldQuery=$true)]
    [String]$Name

    Software([apiMapper]$mapper){

    }

}