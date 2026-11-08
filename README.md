# mantia

Por: Nicolas Bernal M.

# Caso: Mantenimiento de activos en una oficina

* Gestionar solicitudes de mantenimiento para activos de una sola oficina. El solicitante reporta, un supervisor autoriza y un técnico diagnostica y ejecuta el trabajo.

# Roles

| Rol         | Acciones obligatorias                                                                            |
| ----------- | ------------------------------------------------------------------------------------------------ |
| Solicitante | Consulta activos, reporta una falla y consulta sus solicitudes.                                  |
| Supervisor  | Autoriza o rechaza, fija prioridad y asigna técnico; valida el cierre.                           |
| Técnico     | Consulta órdenes asignadas, registra diagnóstico, inicia reparación y reporta trabajo terminado. |

# Instrucciones de ejecucion

Antes de ejecutar, tener un ambiente donde ejecutarlo (como android studio).

1. Clonar el proyecto: `git clone https://github.com/NicolasBernal1/mantia.git`
2. Instalar dependencias: `npm i` 
3. Instalar dependencias de flutter: `flutter pub get`
4. Correr el proyecto: `flutter run -d <device_id>`
5. Correr el proyecto desde la apk: `flutter install --release -d <device_id>`

# Configuracion de firebase
* Autenticacion con correo y contraseña.
* Base de datos firestore.
* Crashlytics habilitado.

# Endpoint HTTP
[JSON](https://dummyjson.com/c/c104-f09e-43d1-b06f) con los activos de la plataforma.

# Modelos de datos
* users: created_at, display_name, email, role, uid
* orders: asset_code, asset_id. asset_name, close_result, created_at, description, diagnosis_cause, estimated_cost, id, priority, rejection_reason, requester_name, requester_uid, status, technician_name, technician_uid, updated_at
* assets: active_order_d, updated_at

# Reglas de negocio
1. No autorizar una segunda orden activa para el mismo activo. Validar y ocupar el activo de forma atómica al autorizar.
2. Solo el técnico asignado registra diagnóstico y reparación; el diagnóstico incluye una causa y un costo estimado no negativo.
3. Una reparación solo inicia con diagnóstico completo y costo dentro del presupuesto fijo de $300.000; la app no aumenta el presupuesto automáticamente.
4. Solo el supervisor cierra una orden terminada, después de registrar el resultado de su verificación. Cerrar o rechazar libera el activo para una nueva orden.

# Operacion local-first
* al reportar una falla se guarda en Drift (pendingSync = true) y luego intenta enviarla.
* Solo se marca sincronizada despues de que lo confirme el servidor y solo si local_version coincide con la version que se envia.
* Si se esta sin conexion queda pendiente, se reintenta con el icono de sincronizar y al abrir la bandeja.
* Si el servidor niega el cambio, se guarda el motivo y el usuario puede reintentar o descartar el cambio local.
* El envio crea si no existe, entonces un reintento nunca pisa una aprobacion del supervisor.
* Autorizar, rechazar, cerrar y las acciones del tecnico requieren conexion y leen el estado del servidor antes de aplicarse.

# Limites
* Es para una sola oficina. 
* Las acciones de supervisor y tecnico requieren conexion (intencionalmente).
* Los cambios de otras cuentas se ven al abrir la bandeja o tocar sincronizar (no hay actualizacion en vivo).
* El catalogo HTTP no se guarda en el dispositivo.
* No hay pantalla para administrar usuarios (los roles se manejan desde firestore).

# Evidencia Crashlytics

En `docs\images\crashlytics.png`

# QA

En `docs\matriz_qa.md`
