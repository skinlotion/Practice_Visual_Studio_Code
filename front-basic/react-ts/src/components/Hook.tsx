import { useState } from 'react'

export const Component1 = () => {
   const {state1, state2, state3} = useStates();

   return <></>;
}

const Component2 = () => {
    const [state1, setState1] = useState<String>('');
    const [state2, setState2] = useState<number>(0);
    const [state3, setState3] = useState<boolean>(false);
    
    return <></>;
}

export default Component2;

const Component3 = () => {
    const [state1, setState1] = useState<String>('');
    const [state2, setState2] = useState<number>(0);
    const [state3, setState3] = useState<boolean>(false);
    
}

const useStates = () => {
    const [state1, setState1] = useState<String>('');
    const [state2, setState2] = useState<number>(0);
    const [state3, setState3] = useState<boolean>(false);

    return {state1, state2, state3, setState1, setState2, setState3};
}