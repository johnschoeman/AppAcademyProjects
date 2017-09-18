export const getBenches = () => {
  return $.ajax({
    method: "GET",
    url: "api/benches"
  });
};

export const postBench = (bench) => {
  return $.ajax({
    method: "POST",
    url: "api/benches",
    data: { bench }
  });
};
