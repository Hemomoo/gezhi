import { createProdMockServer } from "vite-plugin-mock/es/createProdMockServer";
import timeList from "./time-line";
import attachment from "./attachment";

export const mockModules = [...timeList,...attachment];

export default function setupProdMockServer() {
    createProdMockServer(mockModules);
}