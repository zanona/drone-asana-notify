#!/bin/sh

main() {
    test ! "$PLUGIN_PROJECT" && echo "missing 'project' parameter" && exit 1
    test ! "$PLUGIN_TOKEN" && echo "missing 'token' parameter" && exit 1

    ASANA_URL="https://app.asana.com/api/1.0/projects/$PLUGIN_PROJECT/project_statuses"
    RELEASE_URL="https://github.com/$DRONE_REPO/releases/$DRONE_TAG"

    MESSAGE="$(git tag -l "$DRONE_TAG" --format='%(contents)')"
    TEXT="$(printf "%s\n\n%s" "$MESSAGE" "$RELEASE_URL")"

    JSON=$(jq -nc \
	--arg title "$DRONE_REPO@$DRONE_TAG" \
	--arg text  "$TEXT" \
	--arg color "green" \
	'.={data:{color: $color, title: $title, text: $text}}')

    curl -sS -XPOST "$ASANA_URL" \
	-H "Authorization: Bearer $PLUGIN_TOKEN" \
	-H "Content-Type: application/json" \
	-d "$JSON"
}

main "$@"
