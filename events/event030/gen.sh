lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 17.496016016016018 --fixed-mass2 53.13069069069069 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1015080577.9191291 \
--gps-end-time 1015087777.9191291 \
--d-distr volume \
--min-distance 2768.1796183756232e3 --max-distance 2768.1996183756237e3 \
--l-distr fixed --longitude 58.539039611816406 --latitude -48.182315826416016 --i-distr uniform \
--f-lower 20 --disable-spin \
--waveform SEOBNRv4_ROM

bayestar-sample-model-psd \
-o psd.xml \
--H1=aLIGOZeroDetHighPower \
--L1=aLIGOZeroDetHighPower \
--V1=AdvVirgo

bayestar-realize-coincs \
-o coinc.xml \
inj.xml --reference-psd psd.xml \
--detector H1 L1 V1 \
--measurement-error gaussian-noise \
--snr-threshold 4.0 \
--net-snr-threshold 12.0 \
--min-triggers 2 \
--keep-subthreshold

bayestar-localize-coincs coinc.xml
