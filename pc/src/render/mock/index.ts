import { createProdMockServer } from "vite-plugin-mock/es/createProdMockServer";
import timeList from "./time-line";

export const mockModules = [...timeList];

export function setupProdMockServer() {
    createProdMockServer(mockModules);
}