lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 53.80304304304305 --fixed-mass2 84.39507507507508 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1008918107.7120848 \
--gps-end-time 1008925307.7120848 \
--d-distr volume \
--min-distance 6896.859751396162e3 --max-distance 6896.879751396163e3 \
--l-distr fixed --longitude -100.11029052734375 --latitude -24.255373001098633 --i-distr uniform \
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
