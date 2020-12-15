window.addEventListener("DOMContentLoaded", () => {

  // 決済処理を許可するurlは</items/:id/transactions>の場合です。
  const path = location.pathname
  const params = path.replace(/items/g, '').replace(/transactions/g, '').replace(/\//g, '');

  if (path.includes("items") && path.includes("transactions") && /^([1-9]\d*|0)$/.test(params)) {
    const PAYJP_PK = process.env.PAYJP_PK
    Payjp.setPublicKey("pk_test_de7b9636f0b6dd5a5f67bb6a");
    const form = document.getElementById("charge-form");

    form.addEventListener("submit", (e) => {
      e.preventDefault();
      const sendWithoutCardInfo = () => {
        document.getElementById("card-number").removeAttribute("name");
        document.getElementById("card-cvc").removeAttribute("name");
        document.getElementById("card-exp-month").removeAttribute("name");
        document.getElementById("card-exp-year").removeAttribute("name");
        document.getElementById("charge-form").submit();
        document.getElementById("charge-form").reset();
      }
      const formResult = document.getElementById("charge-form");
      const formData = new FormData(formResult);

      // カード情報の構成や、トークン生成はこちらのリファレンスを参照
      // https://pay.jp/docs/payjs-v1
      const card = {
        number: formData.get("number"),
        cvc: formData.get("cvc"),
        exp_month: formData.get("exp_month"),
        exp_year: `20${formData.get("exp_year")}`,
      };
      console.log(card);

      Payjp.createToken(card, (status, response) => {
        console.log(status)
        console.log(response)
        if (status === 200) {
          // response.idでtokenが取得できます。
          const token = response.id;
          const renderDom = document.getElementById("charge-form");
          // サーバーにトークン情報を送信するために、inputタグをhidden状態で追加します。
          const tokenObj = `<input value=${token} type="hidden" name='token'>`;
          renderDom.insertAdjacentHTML("beforeend", tokenObj);
          console.log(tokenObj)
          sendWithoutCardInfo()
        } else {
          // window.alert('購入処理に失敗しました。\nお手数ですが最初からやり直してください。');
          sendWithoutCardInfo()
        }
      });
    });
  }
});
