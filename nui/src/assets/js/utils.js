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

Object.defineProperty(String.prototype, 'ucFirst', {
  value: function() {
    return this.slice(0,1).toUpperCase() + this.slice(1).toLowerCase();
  },
  enumerable: false
});

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

/**
 * Simple object check.
 * @param item
 * @returns {boolean}
 */
function isObject(item) {
  return (item && typeof item === 'object' && !Array.isArray(item));
}
  
/**
 * Deep merge two objects.
 * @param target
 * @param ...sources
 */
function mergeDeep(target, ...sources) {
  if (!sources.length) return target;
  const source = sources.shift();

  if (isObject(target) && isObject(source)) {
    for (const key in source) {
      if (isObject(source[key])) {
        if (!target[key]) Object.assign(target, { [key]: {} });
        mergeDeep(target[key], source[key]);
      } else {
        Object.assign(target, { [key]: source[key] });
      }
    }
  }

  return mergeDeep(target, ...sources);
}

function calculateMapPosPercentage(x, y) {
  let min_x = -4000;
  let max_x = 4500;
  
  let min_y = -4000;
  let max_y = 8000;

  let rx = x - min_x;
  let ry = y - min_y;

  return {
      x: rx / (max_x - min_x),
      y: ry / (max_y - min_y),
  }

}

export { isFivemNUI, getRandomRange, getRandomRangeFloor, getRandomRangeCeil, getRandomRangeRound, isObject, mergeDeep, calculateMapPosPercentage }