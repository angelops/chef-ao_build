# zip_build-cookbook

TODO: Enter the cookbook description here.

## Supported Platforms

TODO: List your supported platforms.

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['zip_build']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
</table>

## Usage

### zip_build::default

Include `zip_build` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[zip_build::default]"
  ]
}
```

## License and Authors

Author:: Justin Alan Ryan (ZipRealty / Realogy) (<juryan@ziprealty.com>)
