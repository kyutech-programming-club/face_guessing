run-dev: run-dev
	fvm flutter run --dart-define=FLAVOR=dev

run-prod: run-prod
	flutter run --dart-define=FLAVOR=prod

pod-install: pod-install
	sudo gem install cocoapods
	sudo gem install ffi
	cd ios; pod install 

clean: clean
	fvm flutter clean
	cd ios; rm -rf Podfile.lock Pods
	fvm flutter pub get
	make pod-install

.PHONY: build-runner
build-runner: 
	fvm flutter packages pub run build_runner build --delete-conflicting-outputs

release-ios-dev: release-ios-dev
	fvm flutter build ios --dart-define=FLAVOR=dev

release-ios-prod: release-ios-prod
	fvm flutter build ios --dart-define=FLAVOR=prod

release-ios-deploygate: release-ios-deploygate
	fvm flutter build ipa --dart-define=FLAVOR=dev --release --export-options-plist="ios/ExportOptionsDev.plist"

release-android-deploygate: release-android-deploygate
	fvm flutter build appbundle --dart-define=FLAVOR=dev --release