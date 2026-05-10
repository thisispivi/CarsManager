.PHONY: verify test build-android build-web release-beta release

verify:
	npm run verify

test:
	cd cars_manager && flutter test --coverage

build-android:
	cd cars_manager && flutter build apk --release --split-per-abi

build-web:
	cd cars_manager && flutter build web --release

release-beta:
	@read -p "Version (e.g. 1.1.0-beta.1): " v; \
	cd cars_manager && sed -i "s/^version:.*/version: $$v+$$(date +%s)/" pubspec.yaml; \
	cd .. && git add cars_manager/pubspec.yaml CHANGELOG.md; \
	git commit -m "chore(release): v$$v"; \
	git tag v$$v; \
	git push origin main --tags

release:
	@read -p "Version (e.g. 1.1.0): " v; \
	cd cars_manager && sed -i "s/^version:.*/version: $$v+$$(date +%s)/" pubspec.yaml; \
	cd .. && git add cars_manager/pubspec.yaml CHANGELOG.md; \
	git commit -m "chore(release): v$$v"; \
	git tag v$$v; \
	git push origin main --tags
