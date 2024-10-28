function isFivemNUI() {
    try {
        // GetParentResourceName est spécifique à FiveM
        return !!GetParentResourceName();
    } catch (error) {
        return false; // Si l'appel échoue, cela signifie que l'on n'est pas dans un environnement FiveM
    }
}

const getRandomRange = (min,max) => {
	return Math.random() * (max - min) + min;
}
const getRandomRangeFloor = (min,max) => {
	return Math.floor(Math.random() * (max - min) + min);
}
const getRandomRangeCeil = (min,max) => {
	return Math.ceil(Math.random() * (max - min) + min);
}
const getRandomRangeRound = (min,max) => {
	return Math.round(Math.random() * (max - min) + min);
}

Math.clamp = function(v, min, max) {
    return Math.max(min ?? v, Math.min(v, max ?? v));
}

Object.defineProperty(Number.prototype, 'clamp', {
    value: function(min, max) {
        return Math.clamp(this, min, max);
    },
    enumerable: false
});

Object.defineProperty(Array.prototype, 'get', {
    value: function(index) {
        if (index < 0) return this[this.length + index];
        return this[index];
    },
    enumerable: false
});

Object.defineProperty(Array.prototype, 'getRandomElement', {
    value: function() {
        return this[Math.floor(Math.random() * this.length)];
    },
    enumerable: false
});

export { isFivemNUI, getRandomRange, getRandomRangeFloor, getRandomRangeCeil, getRandomRangeRound }