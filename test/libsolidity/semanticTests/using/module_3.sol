==== Source: A ====
function id(uint x) pure returns (uint) {
    return x;
}

function zero(uint) pure returns (uint) {
    return 0;
}

function one(uint) pure returns (uint) {
    return 1;
}

==== Source: B ====
import {id as Id} from "A";
import {zero as Zero, one as One} from "A";

contract C {
    using Id for uint;
    using {Zero, One} for *;
	function f(uint x) public pure returns (uint) {
        return x.Id();
    }
	function g(uint x) public pure returns (uint) {
        return x.One();
    }
	function h(uint x) public pure returns (uint) {
        return x.Zero();
    }
}
// ====
// compileViaYul: also
// ----
// f(uint256): 10 -> 10
// g(uint256): 10 -> 1
// h(uint256): 10 -> 0
// f(uint256): 256 -> 0x0100
// g(uint256): 256 -> 1
// h(uint256): 256 -> 0
