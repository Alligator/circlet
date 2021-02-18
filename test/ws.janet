(import build/circlet :as circlet)
(import json)

(defn handle-websocket [req]
  (pp req)
  (case (req :event)
    :connect
    "you are connected"

    :frame
    (loop [client :in (:get-clients req)]
      (:send client (req :data)))))

(circlet/server
  (->
    {"/ws" handle-websocket
     :default {:kind :file
               :file "test/ws.html"
               :mime "text/html"}}
    circlet/router
    circlet/logger)
  8000)
