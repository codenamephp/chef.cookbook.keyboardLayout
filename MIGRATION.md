# Migration

## From codenamephp_system

If you have used the recipe you need to call the resource yourself.

The resource stayed mostly the same but instead of attributes of the node the variables are now passed directly to the resource. If you didn't use any
custom attributes there's nothing to do since the default values are the same.

If you did use attributes just set them as properties of the resource call.