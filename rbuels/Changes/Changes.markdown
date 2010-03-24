# Changelog

* `update` should trigger "update" event, add separate `merge` method.
* Fix that persistence failure should not trigger corresponding event.

## 0.6.0

* Pass only a single callback to save/destroy which is called with a boolean to indicate success/failure.
* Bundle release into a single, versioned Javascript file plus minified version.
* Change behaviour of `Model.Collection` and don't let duplicates (scoped by id) of the same model to be stored. [Laurie Young]

   lib/Bio/Chado/Schema/CellLine/CellLine.pm
       cell_line_relationship_subject_ids -> cell_line_relationship_subjects
       cell_line_relationship_object_ids  -> cell_line_relationship_objects
    
   lib/Bio/Chado/Schema/Contact/Contact.pm
       contact_relationship_object_ids -> contact_relationship_objects
       contact_relationship_subject_ids -> contact_relationship_subjects

## 0.5.1

* Fix that setting a null value with `attr` should be read back correctly from `changes`.
* `errors` array shouldn't have to be manually `reset` when implementing `validate`.

## 0.5.0

* First tagged release.
