function empty(text) {
    var allSpacesRe = /\s+/g;
    text = text.replace(allSpacesRe, "");
    if (text === "") {
        return true
    } else {
        return false
    }
}