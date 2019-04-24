# Waracle-CakeList-Solution
This repo contains my submission for the Waracle Cake List iOS developer test.

#### The solution contains the following:

* A fix for the crash caused by the cell identifier mismatch when dequeuing the cell.
* Modeling of the JSON objects representing cakes.
* Adjustment of the `CakeCell` view constraints so the cells can be viewed correctly.
* Asynchronous requests for downloading the images for each table cell so the UI is not blocked.
* The refresh control has been hooked up to allow for new cake data to be downloaded manually when pulling down on the table view.
* `CakeCells` are reset in `prepareForReuse` to avoid UI persisting when a cell is reused by the table view.
* Tests for the asynchronous image download requests.
* Some UI Improvements and several bits of refactoring.
