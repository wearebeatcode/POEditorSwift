# POEditorSwift

[![Version](https://img.shields.io/cocoapods/v/POEditorSwift.svg?style=flat)](https://cocoapods.org/pods/POEditorSwift)
[![License](https://img.shields.io/cocoapods/l/POEditorSwift.svg?style=flat)](https://cocoapods.org/pods/POEditorSwift)
[![Platform](https://img.shields.io/cocoapods/p/POEditorSwift.svg?style=flat)](https://cocoapods.org/pods/POEditorSwift)

This library is still in Alpha version.

This is an unofficial [POEditor](https://poeditor.com) Swift library. The main purpose of this library is to make available string translations without being forced to static Localizable.strings files that can be updated only with new releases.

POEditorSwift downloads translations using POEditor APIs and store them locally. A new update is performed only if a new version of a specific language is available remotly.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

POEditorSwift is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'POEditorSwift'
```

## Usage

### Initialization

In your AppDelegate didFinishLaunchingWithOptions method initialize POEditorSwift with your API key. You can find your API Key in your [POEditor Account Settings Page](https://poeditor.com/account/api)

```swift
import POEditorSwift

POEditor.start(withKey: "YOUR-API-KEY")
```

### Update translations

Now you just have to load translations for a specific project id. Completion block will inform you if thare was an error during update phase. If error is nil everything is updated correctly.

```swift
do {
    try POEditor.updateLanguages(for: PROJECT-ID) { error in 
        //check error on completion
    }
} catch {
    //probably you forgot to start POEditor with API key
}

```

### Discover project

If you don't know your project number or you prefer to load it programmatically you can gat all projects from you account using:

```swift
POEditor.getProjects { (result) in
            switch result{
            case .success(let projects):
                //All projects
                return
            case .failure(let error):
                //Error
                return
            }
        }
```

### Translate a string

To translate a string just use String class extension:

```swift
// Use Locale.current language code
"myString".localize()

// Force a specific language code
"myString".localize(in: "Language code, IE: en")
```

If the requested translation is not available it will fallback on NSLocalizedString

## TODOs

Before declaring this library in beta version there's still some work to do:
- [ ] Unit test the whole library
- [ ] Add Travis CI
- [ ] Add swiftlint
- [ ] I'm sure that this list is longer but i don't know how to fill it

## Author

Giuseppe Travasoni, giuseppe.travasoni@gmail.com

## License

POEditorSwift is available under the MIT license. See the LICENSE file for more info.
