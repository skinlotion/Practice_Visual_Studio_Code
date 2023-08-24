import { create } from "zustand";

//! 1번째 작업 (zustand 사용하는법)
// let useGlobalStore : any = create();

//! 2번째 작업 (zustand 사용하는법)
// useGlobalStore = create((set) => ());

//! 3번째 작업 (zustand 사용하는법)
// const [ satate1, setState1] = useState<number>(0);
// useGlobalStore = create((set) => ({
//     state1 : 0,
// }))

//! 4번째 작업 (zustand 사용하는법)
// const [ satate1, setState1] = useState<number>(0);
// useGlobalStore = create((set) => ({
//     state1 : 0,
//     setState1: (state1 : number) => {set()}
// }))

//! 5번째 작업 (zustand 사용하는법)
// const [ satate1, setState1] = useState<number>(0);
// useGlobalStore = create((set) => ({
//     state1 : 0,
//     state2 : 0,
//     setState1: (state1 : number) => {set((state) => ({ ...state}))} 
//     // {...state} 는 {state1: 0, state2: 0}과 같다
// }))

//! 7번째 작업 객체에 대한 타입 만들어줌 (zustand 사용하는법)

interface GlobalStore {
    state1 : number;
    state2 : number;
    setState1 : (state1 : number) => void;
}

//! 6번째 작업 (zustand 사용하는법)
// const [ satate1, setState1] = useState<number>(0);
const useGlobalStore = create<GlobalStore>((set) => ({
    state1 : 0,
    state2 : 0,
    setState1: (state1 : number) => {set((state) => ({ ...state, state1}))} 
    // {...state, state1} 는 {state1: 2, state2: 0}과 같다
    // setState1(2);
}));


export default useGlobalStore;

