<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-04-28 at 16 58 09" src="https://github.com/user-attachments/assets/de7a9e3d-1180-4cbe-8af6-9b40dce0c424" />
<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-04-28 at 16 59 57" src="https://github.com/user-attachments/assets/25601855-8d6e-4fb0-a320-00316b36b953" />
<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-04-28 at 17 00 10" src="https://github.com/user-attachments/assets/9bf2780c-fefb-49b6-a65f-611e3bab0022" />
<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-04-28 at 17 04 15" src="https://github.com/user-attachments/assets/9d76df9b-69c1-4efd-b90e-8945b3999e76" />
# IMDUMB - app info movie and recomedations

App iOS que muestra categorías de películas con detalle de cada una.

---

## Tech Stack

| Tecnología | Versión |
|---|---|
| Xcode | 15+ |
| Swift | 5.9+ |
| Alamofire | 5.11.2 |
| Firebase iOS SDK | 12.12.1 |
| Arquitectura | MVP + Clean |
| UI | UIKit + .xib |

---

## Cómo Ejecutar

```bash
git clone https://github.com/TU_USUARIO/IMDUMB.git
cd IMDUMB
open IMDUMB.xcodeproj
```

1. Abre `IMDUMB.xcodeproj` en Xcode
3. El `GoogleService-Info.plist` ya está incluido ✅
4. Selecciona un simulador iOS
5. `⌘R` para compilar y correr

---

## Schemes disponibles

| Scheme | Ambiente | Uso |
|---|---|---|
| `IMDUMB` | Debug | Desarrollo |
| `IMDUMB-Staging` | Staging | QA / Testing |

---

## Endpoints usados

Base URL: `https://api.themoviedb.org/3`

| Endpoint | Descripción |
|---|---|
| `/movie/popular` | Películas populares |
| `/movie/top_rated` | Mejor valoradas |
| `/movie/upcoming` | Próximas |
| `/movie/now_playing` | En cines |
| `/movie/{id}/credits` | Actores |

---

## Principios SOLID documentados

| Principio | Archivo | Descripción |
|---|---|---|
| SRP | `NetworkManager.swift` | Solo maneja peticiones HTTP |
| DIP | `MovieRepository.swift` | Depende de protocolo, no implementación |
| ISP | `ViewProtocol.swift` | Interfaces segregadas por pantalla |
| OCP | `UIImageView+Load.swift` | Extendemos sin modificar |

---

## Arquitectura

Presentation  →  Presenter  →  UseCase  →  Repository  →  DataStore
(View/xib)       (MVP)         (Domain)     (Data)         (Remote/Mock)

## Mocks

Para usar datos mock en lugar de la API real,
cambia en `HomePresenter.swift`:

```swift
// Cambiar esto:
FetchMoviesUseCase()

// Por esto:
FetchMoviesUseCase(
    repository: MovieRepository(dataStore: MockMovieDataStore())
) //comment init 
```
