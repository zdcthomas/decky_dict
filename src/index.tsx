import {
  ButtonItem,
  definePlugin,
  DialogButton,
  Menu,
  MenuItem,
  PanelSection,
  PanelSectionRow,
  Router,
  ServerAPI,
  showContextMenu,
  staticClasses,
} from "decky-frontend-lib";
import { useState, VFC } from "react";
import { FaShip } from "react-icons/fa";

import * as backend from "./backend";

var usdplReady: boolean = false;

// interface AddMethodArgs {
//   left: number;
//   right: number;
// }

const Content: VFC<{ serverAPI: ServerAPI }> = ({ serverAPI }) => {
  // const [result, setResult] = useState<number | undefined>();

  // const onClick = async () => {
  //   const result = await serverAPI.callPluginMethod<AddMethodArgs, number>(
  //     "add",
  //     {
  //       left: 2,
  //       right: 2,
  //     }
  //   );
  //   if (result.success) {
  //     setResult(result.result);
  //   }
  // };

  const [name, setName] = useState("Server says yolo");
  const [firstTime, setFirstTime] = useState<boolean>(true);
  const [_serverApiGlobal, setServerApi] = useState<ServerAPI>(serverAPI);
  backend.resolve(backend.name(), setName);

  if (firstTime) {
    setFirstTime(false);
    setServerApi(serverAPI);
    // backend.resolve(backend.getEnabled(), setEnable);
    // backend.resolve(backend.getInterpolate(), setInterpol);
    // backend.resolve(backend.getCurve(), setCurve);
    // backend.resolve(backend.getTemperature(), setTemperature);
    // backend.resolve(backend.getFanRpm(), setFanRpm);
  }

  if (!usdplReady) {
    return <PanelSection></PanelSection>;
  }

  return (
    <PanelSection title="Panel Section">
      <PanelSectionRow>
        <ButtonItem
          layout="below"
          onClick={(e) =>
            showContextMenu(
              <Menu label="Menu" cancelText="CAAAANCEL" onCancel={() => {}}>
                <MenuItem onSelected={() => {}}>{name}</MenuItem>
                <MenuItem onSelected={() => {}}>Item #2</MenuItem>
                <MenuItem onSelected={() => {}}>Item #3</MenuItem>
              </Menu>,
              e.currentTarget ?? window
            )
          }
        >
          {name}
        </ButtonItem>
      </PanelSectionRow>

      <PanelSectionRow>
        <ButtonItem
          layout="below"
          onClick={() => {
            Router.CloseSideMenus();
            Router.Navigate("/decky-plugin-test");
          }}
        >
          Router
        </ButtonItem>
      </PanelSectionRow>
    </PanelSection>
  );
};

const DeckyPluginRouterTest: VFC = () => {
  return (
    <div style={{ marginTop: "50px", color: "white" }}>
      Hello World!
      <DialogButton onClick={() => Router.NavigateToStore()}>
        Go to Store
      </DialogButton>
    </div>
  );
};

export default definePlugin((serverApi: ServerAPI) => {
  serverApi.routerHook.addRoute("/decky-plugin-test", DeckyPluginRouterTest, {
    exact: true,
  });

  (async function () {
    await backend.initBackend();
    usdplReady = true;
    //backend.getEnabled().then((enabled: boolean) => {
    //  //@ts-ignore
    //  SteamClient.System.SetBetaFanControl(!enabled);
    //});
  })();

  // let ico = <FaFan />;
  // let now = new Date();
  // if (now.getDate() == 1 && now.getMonth() == 3) {
  //   ico = <SiOnlyfans />;
  // }

  return {
    title: <div className={staticClasses.Title}>Decky Dict</div>,
    content: <Content serverAPI={serverApi} />,
    icon: <FaShip />,
    onDismount() {
      serverApi.routerHook.removeRoute("/decky-plugin-test");
    },
  };
});
