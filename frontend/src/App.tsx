import { HashRouter } from "react-router";
import { Admin, Resource } from "react-admin";
import {
  BulletinCreate,
  BulletinEdit,
  BulletinList,
  BulletinShow,
} from "./bulletins";
import { dataProvider } from "./dataProvider";
import { Layout } from "./Layout";

export const App = () => (
  <HashRouter>
    <Admin layout={Layout} dataProvider={dataProvider}>
      <Resource
        name="bulletins"
        list={BulletinList}
        create={BulletinCreate}
        edit={BulletinEdit}
        show={BulletinShow}
        recordRepresentation="title"
      />
    </Admin>
  </HashRouter>
);
