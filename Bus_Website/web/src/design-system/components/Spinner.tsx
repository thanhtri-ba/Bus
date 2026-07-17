export function Spinner({label='Đang tải'}:{label?:string}){return <span className="spinner-wrap" role="status"><span className="spinner"/><span className="sr-only">{label}</span></span>}
