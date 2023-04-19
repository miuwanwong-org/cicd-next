import dynamic from "next/dynamic";

const DynamicHome = dynamic(() => import("./home"), {
	ssr: false,
});

export default function Index() {
	return <DynamicHome />;
}
