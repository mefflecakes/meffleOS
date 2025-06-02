# Allow build scripts to be referenced without being copied into the final image
FROM scratch AS ctx
COPY build_files /build_files

# Base Image
FROM ghcr.io/ublue-os/bazzite:stable

### MODIFICATIONS
RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    /ctx/build_files/build.sh && \
    ostree container commit

### LINTING
# You can keep this if you want another validation run,
# or remove it if the above already covers everything.
