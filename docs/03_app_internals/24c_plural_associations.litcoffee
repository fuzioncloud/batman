# /api/App Internals/Batman.Association/Batman.PluralAssociation

`Batman.PluralAssociation` extends `Batman.Association`. It is an abstract class extended by `Batman.HasManyAssociation` and `Batman.PolymorphicHasManyAssociation`.

## ::constructor(@model, @label, options[={}]) : PluralAssociation

## ::provideDefaults() : Option

Extends default options from `Batman.Association` with:

- `name`: camelized and singularized `@label`

## ::setForRecord(record) : Set

Returns a `Batman.AssociationSet` for `record`'s children.

## ::setForKey(indexValue) : Set

Returns a `Batman.AssociationSet` for children whose foreign key is `indexValue`.

## ::proxyClassInstanceForKey(indexValue)

Returns a new instance of `proxyClass` for `indexValue`.

## ::getAccessor(self, model, label)

Returns the appropriate `Batman.AssociationSet` as this association's value.

## ::parentSetIndex() : UniqueSetIndex

Returns `@model`'s loaded set, indexed by `@primaryKey`.

## ::setIndex() : SetIndex

Returns a `Batman.AssociationSetIndex` for this association.

## ::indexValueForRecord(record)

Returns `record`'s value for `@primaryKey`.

## ::.proxyClass[=Batman.AssociationSet]
## ::.isSingular[=false]
## ::reset()

# /api/App Internals/Batman.Association/Batman.HasManyAssociation

`Batman.HasManyAssociation` backs associations defined with `@hasMany`. If the `as` option is passed, it will be backed with `Batman.PolymorphicHasManyAssociation` instead.

## ::constructor(model, label, options)

Returns a `Batman.PolymorphicHasManyAssociation` if `options.as`. Otherwise, returns a new `Batman.HasManyAssociation`.

## ::provideDefaults() : Object

Extends defaults from `Batman.PluralAssociation` with:

- `primaryKey`: `"id"`
- `foreignKey`: `"#{Batman.helpers.underscore(@model.get('resourceName'))}_id"`

## ::apply(baseSaveError, base)

Called after the `hasMany` parent is saved. It updates all foreign keys on child records and marks the `Batman.AssociationSet` as loaded.

## ::encoder() : Function

Returns a function for turning the association into JSON. if `@options.encodeWithIndexes` is true, it encodes into an object whose keys are indexes. Otherwise, it encodes into an array.

## ::decoder() : Function

Returns a function that decodes the association from an array. When it is loading records, it adds any new records to their respective `loaded` sets.

Even if a record is not in the JSON, it won't be removed from the association set. You must do this yourself.

# /api/App Internals/Batman.Association/Batman.PolymorphicHasManyAssociation

`Batman.PolymorphicHasManyAssociation` extends `Batman.HasManyAssociation` and backs associations defined with `@hasMany as: "..."`.

## ::constructor(model, label, options) : PolymorphicHasManyAssociation

Assigns `options.as` to `@foreignLabel`, then deletes the option and calls super.

## ::provideDefaults() : Object

Extends default options from `Batman.HasManyAssociation` with:

- `inverseOf`: `options.as`
- `foreignKey`: `{options.as}_id`

## ::provideDefaults() :
## ::apply(baseSaveError, base)

Updates children's `foreignTypeKey` to `@modelType()`.

## ::proxyClassInstanceForKey(indexValue)

Returns a new instance of `@proxyClass` for `indexValue` and `@modelType()`.

## ::getRelatedModelForType(type)

If `type` is passed, it will search for a model with name `type` or camelized `type`. Otherwise, it will use `@getRelatedModel()`.

## ::modelType()

Returns the `resourceName` of `@model`.

## ::setIndex()

Rreturns a `Batman.PolymorphicAssociationSetIndex` for this association.

## ::encoder() : Function

Returns a function that encodes the association into an array.

## ::decoder() : Function

Returns a function that decodes the association from an array. It also adds new records to their `loaded` sets.

Even if a record _is not_ present in the JSON, it won't be removed from the association set. You must remove records yourself.

## ::.proxyClass[=Batman.PolymorphicAssociationSet]
## ::.isPolymorphic[=true]